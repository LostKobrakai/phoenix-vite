export default {
  build: {
    manifest: true,
    rollupOptions: {
      // overwrite default .html entry
      input: 'js/main.js'
    },
    outDir: "../priv/static",
    emptyOutDir: true
  }
}