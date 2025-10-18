import { deleteComment } from "../api/comment/deleteComment";
import { generateComments } from "../helpers/generateComments";

export const initCommentDelete = () => {
  const container = document.querySelector("#js-comment-container");
  if (!container) return;

  container.addEventListener("click", async (e) => {
    const target = e.target as HTMLElement;
    const button = target?.closest<HTMLElement>(".js-delete-comment-button");
    if (!button) return;
    e.preventDefault();

    const commentId = Number(button.dataset.commentId);
    if (!commentId) return;

    const data = await deleteComment(commentId);
    generateComments(data);
  });
};
