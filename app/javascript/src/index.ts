import { initCommentDelete } from "./modules/initCommentDelete";
import { initCommentPost } from "./modules/initCommentPost";
import { initComments } from "./modules/initComments";
import { initCloseFlash } from "./modules/initCloseFlash";
import { initTaskStatus } from "./modules/initTaskStatus";

document.addEventListener("turbo:load", async () => {
  try {
    await initComments();
    initCloseFlash();
    initCommentPost();
    initCommentDelete();
    initTaskStatus();
  } catch (error) {
    throw error;
  }
});
