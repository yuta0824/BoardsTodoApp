import { postComment } from "../api/comment/postComment";
import { refreshComments } from "../helpers/refreshComments";

export const initCommentForm = () => {
  const taskElement = document.querySelector("[data-board-id][data-task-id]");
  if (!taskElement) return;

  const form = taskElement.querySelector("#js-comment-form");
  if (!form) return;

  const field = form.querySelector<HTMLTextAreaElement>("textarea");
  if (!field) return;

  const boardId = Number(taskElement.getAttribute("data-board-id"));
  const taskId = Number(taskElement.getAttribute("data-task-id"));

  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const content = field.value.trim();
    if (!content) return;

    try {
      await postComment(boardId, taskId, content);
      field.value = "";
      await refreshComments(boardId, taskId);
    } catch (error) {
      console.error(error);
    }
  });
};
