import { Main } from "./Main.elm";
import { unregister } from "./registerServiceWorker";

const app = Main.embed(document.getElementById("root"));

app.ports.setupScrollSpy.subscribe(sections => {
  window.addEventListener("scroll", e => {
    const activeHash =
      sections.find(
        id => (document.querySelector(id) || {}).offsetTop <= e.pageY
      ) || "#home";
    window.history.replaceState(null, null, activeHash);
    app.ports.activeHash.send(activeHash);
  });
});

unregister();
