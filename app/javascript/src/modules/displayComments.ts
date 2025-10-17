import {
  fetchGetComments,
  CommentResponse,
} from "../api/comment/fetchGetComments";
import { escapeHtml } from "../utils/escapeHtml";

export const displayComments = async () => {
  const taskElement = document.querySelector("[data-board-id][data-task-id]");
  const container = document.querySelector("#js-comment-container");
  if (!taskElement || !container) return;

  const boardId = Number(taskElement.getAttribute("data-board-id"));
  const taskId = Number(taskElement.getAttribute("data-task-id"));

  const data = await fetchGetComments(boardId, taskId);
  container.innerHTML = createDom(data);
};

const createDom = (data: CommentResponse[]) => {
  return data
    .map((comment) => {
      return `
        <div class="bg-white shadow-lg rounded-lg p-4 border border-brandGray flex items-center justify-between">
          <div>
            <div class="flex gap-2 items-center">
              <img
                class="flex-shrink-0 size-8 rounded-full"
                src="${escapeHtml(comment.commenter_avatar)}"
                alt="${escapeHtml(comment.commenter_name)} avatar"
              />
              <p class="font-bold text-brandBlack">
                ${escapeHtml(comment.commenter_name)}
              </p>
            </div>
            <div class="mt-4">${escapeHtml(comment.content)}</div>
          </div>
        </div>
      `;
    })
    .join("");
};
