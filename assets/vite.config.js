export default ({ command, mode }) => ({
  build: {
    manifest: true,
    rollupOptions: {
      // overwrite default .html entry
      input: 'js/main.js',
      output: {
        entryFileNames: `assets/[name].js`,
        chunkFileNames: `assets/[name].js`,
        assetFileNames: `assets/[name].[ext]`
      }
    },
    build: {
      base: mode == 'development' ? "http://localhost:3000/" : "/",
      // Needs to be disabled for phoenix assets to always be dumped to fs
      assetsInlineLimit: 0
    },
    outDir: "../priv/static",
    emptyOutDir: true
  }
})