# -*- coding: utf-8 -*-
# pylint: disable=consider-using-f-string,invalid-name,line-too-long,super-with-arguments

'''
Ranger color-scheme using `$LS_COLORS` / `dircolors`.

Originally based on: https://github.com/ranger/colorschemes/raw/a250fe866200940eb06d877a274333a2a54c34f3/ls_colors.py

Usage: copy this file to `~/.config/ranger/colorschemes'. The base color-scheme
used for non file system entries / the unfocused pane is `default`. To change it,
rename this file to `ls_colors_BASE_SCHEME_NAME.py` (e.g. change it to
`ls_colors_snow.py` to use the `snow` color-scheme as base).
'''

import curses
import fnmatch
import importlib
import inspect
import os
import re
import shlex
import subprocess
import sys

import ranger.gui.color as STYLE
import ranger.gui.widgets.browsercolumn
from ranger.gui.colorscheme import ColorScheme, ColorSchemeError
from ranger.gui.context import CONTEXT_KEYS, Context


PY2 = sys.version_info[0] == 2

SPECIAL_PATTERNS = {
    'bd': 'device'    , # block device
    'ca': ''          , # cap
    'cd': 'device'    , # char device
    'cl': ''          , # clear end of line
    'di': 'directory' , # directory
    'do': ''          , # Solaris door
    'ec': ''          , # end color, unused
    'ex': 'executable', # executable
    'fi': 'file'      , # file
    'fl': ''          , # file, default
    'lc': ''          , # left, unused
    'ln': 'link'      , # symlink
    'mh': ''          , # multi hardlink
    'mi': ''          , # missing file
    'no': ''          , # normal
    'or': 'orphan'    , # orphaned symlink
    'ow': ''          , # other-writable
    'pi': 'fifo'      , # pipe
    'rc': ''          , # right, unused
    'rs': ''          , # reset
    'sg': ''          , # setgid
    'so': 'socket'    , # socket
    'st': ''          , # sticky
    'su': ''          , # setuid
    'tw': ''          , # ow with sticky
}

STYLE_ATTRIBUTES = {
    1: STYLE.bold,
    2: STYLE.dim,
    # Italic, not always supported, and
    # not exported by `ranger.gui.color`.
    3: getattr(curses, 'A_ITALIC', 0),
    4: STYLE.underline,
    5: STYLE.blink,
    # Rapid blink.
    6: STYLE.blink,
    7: STYLE.reverse,
    8: STYLE.invisible,
}

def parse_terminal_attributes(attribute_list):
    '''
    Parse a list of ECMA-48 SGR sequence
    parameters to sets display attributes.
    '''
    fg, bg, return_attr = STYLE.default_colors
    attribute_iter = iter(attribute_list)
    for attr in attribute_iter:
        if attr == 0:
            # Reset to default.
            fg, bg, return_attr = STYLE.default_colors
        elif attr in STYLE_ATTRIBUTES:
            return_attr |= STYLE_ATTRIBUTES[attr]
        # Foreground: basic colours.
        elif 30 <= attr <= 37:
            fg = attr - 30
        # Foreground: 256 colors.
        elif attr == 38:
            attr = next(attribute_iter)
            assert attr == 5
            fg = next(attribute_iter)
        # Background: Basic colours.
        elif 40 <= attr <= 47:
            bg = attr - 40
        # Background: 256 colors.
        elif attr == 48:
            attr = next(attribute_iter)
            assert attr == 5
            bg = next(attribute_iter)
        # Foreground: bright version of basic colours.
        elif 90 <= attr <= 97:
            fg = attr - 90 + STYLE.BRIGHT
        # Background: bright version of basic colours.
        elif 100 <= attr <= 107:
            bg = attr - 100 + STYLE.BRIGHT
        else:
            raise ValueError('invalid/unsupported terminal attribute: {}'.format(attr))
    return fg, bg, return_attr

def get_ls_colors():
    '''
    Return `$LS_COLORS` or call `dircolors`
    to get the list colors to used.
    '''
    spec = os.getenv('LS_COLORS')
    if spec is None:
        try:
            spec = subprocess.check_output(('dircolors', '--csh'))
        except (subprocess.CalledProcessError, FileNotFoundError):
            pass
        else:
            spec = shlex.split(spec.decode())
            assert len(spec) == 3 and spec[0:2] == ['setenv', 'LS_COLORS'], spec
            spec = spec[-1]
    if spec is None:
        spec = ''
    return spec

def parse_ls_colors(spec):
    '''
    Parse a `$LS_COLORS` spec.
    '''
    ls_colors = []
    for entry in spec.strip(':').split(':'):
        if not entry:
            continue
        pattern, t_attributes = entry.split('=', 1)
        if pattern != 'ln' or t_attributes != 'target':
            t_attributes = list(map(int, t_attributes.split(';')))
            t_attributes = parse_terminal_attributes(t_attributes)
        ls_colors.append((pattern, t_attributes))
    return ls_colors

def get_base_colorscheme_name():
    '''
    Find out the name of the base color-scheme to use.
    '''
    basename = __name__.rsplit('.', 1)[-1]
    if basename.startswith('ls_colors_'):
        return basename[10:]
    return 'default'

def get_colorscheme_class(name):
    '''
    Return a color-scheme class by (module)
    name, checking for a relative one first.
    '''
    for module_name in (
        (__package__ + '.' if __package__ else '') + name,
        'ranger.colorschemes.' + name
    ):
        try:
            scheme_module = importlib.import_module(module_name)
        except ImportError:
            continue
        for var in scheme_module.__dict__.values():
            if var != ColorScheme and \
               inspect.isclass(var) and \
               issubclass(var, ColorScheme):
                return var
        break
    raise ColorSchemeError("Cannot locate colorscheme `{}'".format(name))


class LsColors(get_colorscheme_class(get_base_colorscheme_name())):

    __doc__ = __doc__

    def __init__(self):
        super(LsColors, self).__init__()
        rx_parts = []
        self.ls_colors = []
        self.pattern_ls_color = []
        self.special_ls_color = {}
        for n, (pattern, t_attributes) in enumerate(parse_ls_colors(get_ls_colors())):
            self.ls_colors.append(t_attributes)
            target = SPECIAL_PATTERNS.get(pattern)
            if target is not None:
                # Special directives.
                self.special_ls_color[target] = n
                continue
            # Other pattern.
            pattern = fnmatch.translate(pattern)
            if PY2:
                assert pattern.endswith(r'\Z(?ms)')
                pattern = pattern[:-7]
            else:
                assert pattern.startswith('(?s:') and pattern.endswith(r')\Z')
                pattern = pattern[4:-3]
            rx_parts.append('(' + pattern + ')')
            self.pattern_ls_color.append(n)
        if PY2:
            # “sorry, but this version only supports 100 named groups”…
            rx_batch_size = 99
        else:
            rx_batch_size = None
        self.pattern_rx_list = []
        ls_color_offset = -1
        while rx_parts:
            rx_batch = rx_parts[:rx_batch_size]
            rx_parts = rx_parts[len(rx_batch):]
            pattern_rx = re.compile('^(?:' + '|'.join(rx_batch) + ')$',
                                    re.DOTALL | re.IGNORECASE)
            self.pattern_rx_list.append((pattern_rx, ls_color_offset))
            ls_color_offset += len(rx_batch)
        self.old_hook_before_drawing = ranger.gui.widgets.browsercolumn.hook_before_drawing
        ranger.gui.widgets.browsercolumn.hook_before_drawing = self.new_hook_before_drawing

    def new_hook_before_drawing(self, fsobject, color_list):
        '''
        Add an `ls_colorN` tag to `color_list`
        if there's an applicable LS colors entry.
        '''
        color_set = frozenset(color_list)
        ls_color = None
        for kind in (
            # Check for symlinks first.
            'link',
            # Then special files.
            'device',
            'fifo',
            'socket',
            # Directories before executables (execute bit).
            'directory',
            'executable',
            # And finally standard files.
            'file',
        ):
            if kind not in color_set:
                continue
            ls_color = self.special_ls_color.get(kind)
            if kind == 'link':
                # Orphaned link?
                if 'bad' in color_set:
                    ls_color = self.special_ls_color.get('orphan', ls_color)
                # Should we look at the link target instead?
                if ls_color is not None and self.ls_colors[ls_color] == 'target':
                    ls_color = None
            elif kind == 'file':
                # Check for a matching pattern.
                for pattern_rx, ls_color_offset in self.pattern_rx_list:
                    m = pattern_rx.match(fsobject.basename)
                    if m is not None:
                        ls_color = self.pattern_ls_color[m.lastindex + ls_color_offset]
                        break
            if ls_color is not None:
                color_list.append('ls_color' + str(ls_color))
                break
        return self.old_hook_before_drawing(fsobject, color_list)

    BASE_IGNORED_TAGS = frozenset((
        'audio',
        'container',
        'document',
        'image',
        'media',
        'video',
    ))

    BASE_DECORATION_TAGS = frozenset((
        'copied',
        'cut',
        'line_number',
        'marked',
        'tag_marker',
    ) + tuple(k for k in CONTEXT_KEYS if k.startswith('vcs')))

    def use(self, context):
        '''
        Return a `(fg, bg, attr)` tuple for colorizing according
        to `context`: if there's an `ls_colorN` attribute, use that,
        otherwise, use the base color-scheme.
        '''
        tags = set()
        style = None
        for k, v in context.__dict__.items():
            if k.startswith('ls_color'):
                style = self.ls_colors[int(k[8:])]
            elif v and k not in self.BASE_IGNORED_TAGS:
                tags.add(k)
        if style is None:
            # No LS color, use base scheme.
            return super(LsColors, self).use(context)
        if not context.in_browser or context.inactive_pane or \
           not context.selected and tags & self.BASE_DECORATION_TAGS:
            # Inactive, or (unselected) decorations, use simplified base scheme.
            tags -= self.BASE_IGNORED_TAGS
            return super(LsColors, self).use(Context(tags))
        # LS color style, unselected.
        if 'selected' not in tags:
            return style
        # LS color style, selected.
        fg, bg, attr = style
        if attr & STYLE.reverse:
            attr &= ~STYLE.reverse
        else:
            attr |= STYLE.reverse
        if 'main_column' in tags:
            attr |= STYLE.bold
        return fg, bg, attr


def test():
    '''
    Test the color-scheme: create a temporary directory
    with a bunch of entries matching the LS colors spec
    and open ranger on it.
    '''
    # pylint: disable=import-outside-toplevel,too-many-locals
    import random
    import shutil
    import socket
    import stat
    import tempfile
    # Randomize a string case.
    def randcase(s):
        nchars = len(s)
        randbits = random.getrandbits(nchars)
        return ''.join(
            c.upper() if b == '1' else c.lower()
            for c, b in zip(s, format(randbits, '0{}b'.format(nchars)))
        )
    def mknod(path, kind):
        os.mknod(path, kind | 0o500)
    def touch(path, mode=0o644):
        os.close(os.open(path, os.O_CREAT, mode))
    def mklink(path, target):
        os.symlink(target, path)
    def mksocket(path):
        so = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
        try:
            so.bind(path)
        finally:
            so.close()
    tmpdir = tempfile.mkdtemp()
    try:
        entry_list = [
            (os.mkdir, 'directory'),
            (os.mkdir, '.hidden_directory'),
            (os.mkdir, '.git'),
            (os.mkdir, 'ceci.n\'est.pas.un.jpeg'),
            (os.mkfifo, 'fifo'),
            (mksocket, 'socket'),
            (mklink, 'symlink_to_dir', 'directory'),
            (mklink, 'symlink_to_executable', 'executable'),
            (mklink, 'symlink_to_file', 'file'),
            (mklink, 'symlink_to_missing', 'missing'),
            (touch, 'executable', 0o755),
            (touch, 'python_script.py', 0o755),
            (touch, 'shell_script.sh', 0o755),
            (touch, '.hidden_file'),
            (touch, '.hidden.jpeg'),
            (touch, 'file'),
        ]
        if os.getuid() == 0:
            entry_list.extend((
                (mknod, 'block_device', stat.S_IFBLK),
                (mknod, 'char_device', stat.S_IFCHR),
            ))
        for entry in filter(None, get_ls_colors().split(':')):
            pattern = entry.split('=', 1)[0]
            if pattern not in SPECIAL_PATTERNS:
                entry_list.append((touch, pattern))
        for args in entry_list:
            fn, name = args[0:2]
            args = args[2:]
            fn(os.path.join(tmpdir, name), *args)
            for unused_retry in range(3):
                alt_name = randcase(name)
                if alt_name != name:
                    fn(os.path.join(tmpdir, alt_name), *args)
                    break
        subprocess.call((sys.executable, '-c', '__import__("ranger").main()', tmpdir))
    finally:
        shutil.rmtree(tmpdir)


if __name__ == '__main__':
    test()
