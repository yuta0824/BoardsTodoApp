import { getComments } from "../api/comment/getComments";
import { generateComments } from "../helpers/generateComments";

export const initComments = async () => {
  const taskElement = document.querySelector("[data-board-id][data-task-id]");
  if (!taskElement) return;

  const boardId = Number(taskElement.getAttribute("data-board-id"));
  const taskId = Number(taskElement.getAttribute("data-task-id"));
  if (!boardId || !taskId) return;

  const data = await getComments(boardId, taskId);
  generateComments(data);
};
