import { postComment } from "../api/comment/postComment";
import { generateComments } from "../helpers/generateComments";

export const initCommentPost = () => {
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
    const data = await postComment(boardId, taskId, content);
    field.value = "";
    generateComments(data);
  });
};
