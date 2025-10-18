import { closeFlash } from "./modules/closeFlash";
import { initCommentForm } from "./modules/initCommentForm";
import { initComments } from "./modules/initComments";

document.addEventListener("turbo:load", () => {
  initComments();
  initCommentForm();
  closeFlash();
});

document.addEventListener("turbo:render", closeFlash);
