import { initCommentDelete } from "./modules/initCommentDelete";
import { initCommentPost } from "./modules/initCommentPost";
import { initComments } from "./modules/initComments";
import { initCloseFlash } from "./modules/initCloseFlash";

document.addEventListener("turbo:load", async () => {
  try {
    await initComments();
    initCloseFlash();
    initCommentPost();
    initCommentDelete();
  } catch (error) {
    throw error;
  }
});
