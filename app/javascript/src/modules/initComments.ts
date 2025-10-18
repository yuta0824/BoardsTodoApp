import { refreshComments } from "../helpers/refreshComments";

export const initComments = () => {
  const taskElement = document.querySelector("[data-board-id][data-task-id]");
  if (!taskElement) return;

  const boardId = Number(taskElement.getAttribute("data-board-id"));
  const taskId = Number(taskElement.getAttribute("data-task-id"));
  if (!boardId || !taskId) return;

  refreshComments(boardId, taskId);
};
