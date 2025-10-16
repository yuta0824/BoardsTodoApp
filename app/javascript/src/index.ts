import { closeFlash } from "./modules/closeFlash";
import { displayComments } from "./modules/displayComments";

document.addEventListener("turbo:load", () => {
  displayComments();
  closeFlash();
});

document.addEventListener("turbo:render", closeFlash);
