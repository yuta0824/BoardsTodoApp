import { closeFlash } from "./modules/closeFlash";
import { initCommentDelete } from "./modules/initCommentDelete";
import { initCommentPost } from "./modules/initCommentPost";
import { initComments } from "./modules/initComments";

document.addEventListener("turbo:load", async () => {
  try {
    closeFlash();
    await initComments();
    initCommentPost();
    initCommentDelete();
  } catch (error) {
    throw error;
  }
});

document.addEventListener("turbo:render", closeFlash);
