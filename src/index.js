import { Main } from "./Main.elm";
import { unregister } from "./registerServiceWorker";

const HAS_SEEN_COMPETITION_COOKIE = "hasSeenCompetitionModal=true";

const hasSeenCompetitionModal = !!document.cookie.match(
  HAS_SEEN_COMPETITION_COOKIE
);

const app = Main.embed(document.getElementById("root"), {
  showCompetitionModal: !hasSeenCompetitionModal
});

if (!hasSeenCompetitionModal) {
  document.cookie = HAS_SEEN_COMPETITION_COOKIE;
}

app.ports.setupScrollSpy.subscribe(sections => {
  window.addEventListener("scroll", e => {
    const activeHash =
      sections.find(
        id => (document.querySelector(id) || {}).offsetTop <= e.pageY
      ) || "#about";
    window.history.replaceState(null, null, activeHash);
    app.ports.activeHash.send(activeHash);
  });
});

unregister();
