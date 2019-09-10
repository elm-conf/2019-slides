const { Elm } = require("./Main.elm");

const app = Elm.Main.init({});

app.ports.toggleFullscreen.subscribe(() => {
  document.body.requestFullscreen();
});
