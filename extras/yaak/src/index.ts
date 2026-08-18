import type { PluginDefinition } from '@yaakapp/api';

// Generated from lua/sora/palette.lua by scripts/extras.lua.

export const plugin: PluginDefinition = {
  themes: [
    {
      id: 'sora',
      label: 'Sora',
      dark: true,
      base: {
        surface: '#0e1018',
        surfaceHighlight: '#171a24',
        surfaceActive: '#283448',
        selection: '#1e2430',
        text: '#c8d0e0',
        textSubtle: '#9aa4b8',
        textSubtlest: '#586478',
        border: '#364050',
        borderSubtle: '#222838',
        borderFocus: '#80c8e0',
        primary: '#80c8e0',
        secondary: '#b0a0d8',
        info: '#5ca8c8',
        success: '#68a888',
        notice: '#d0a888',
        warning: '#c8a860',
        danger: '#c46c78',
      },
      components: {
        appHeader: { surface: '#0a0c12', border: '#222838' },
        sidebar: { surface: '#0a0c12', border: '#222838' },
        responsePane: { surface: '#0e1018', border: '#364050' },
        editor: { surface: '#0e1018' },
        dialog: { surface: '#14161e', border: '#364050' },
        menu: { surface: '#14161e', border: '#364050' },
        toast: { surface: '#14161e', border: '#364050' },
        input: { surface: '#14161e', border: '#364050' },
        urlBar: { surface: '#14161e', border: '#364050' },
        button: {
          primary: '#80c8e0',
          secondary: '#b0a0d8',
          info: '#5ca8c8',
          success: '#68a888',
          notice: '#d0a888',
          warning: '#c8a860',
          danger: '#c46c78',
        },
      },
    },
  ],
};
