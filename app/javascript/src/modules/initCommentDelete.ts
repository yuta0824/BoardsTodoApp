import { deleteCommentAndFetch } from "../api/comment/deleteCommentAndFetch";
import { generateComments } from "../helpers/generateComments";
import {
  hasListenerAttached,
  markListenerAttached,
} from "../utils/eventListener";

export const initCommentDelete = () => {
  const container = document.querySelector<HTMLElement>(
    "#js-comment-container"
  );
  if (!container || hasListenerAttached(container)) return;

  container.addEventListener("click", async (e) => {
    const target = e.target as HTMLElement;
    const button = target.closest<HTMLElement>(".js-delete-comment-button");
    if (!button) return;
    const commentId = Number(button.dataset.commentId);
    if (!commentId) return;

    const data = await deleteCommentAndFetch(commentId);
    generateComments(data);
  });

  markListenerAttached(container);
};
