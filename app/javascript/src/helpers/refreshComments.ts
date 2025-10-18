import { getComments, CommentResponse } from "../api/comment/getComments";
import { escapeHtml } from "../utils/escapeHtml";

export const refreshComments = async (boardId: number, taskId: number) => {
  const container = document.querySelector("#js-comment-container");
  if (!container) return;

  const data = await getComments(boardId, taskId);
  container.innerHTML = buildCommentsHtml(data);
};

const buildCommentsHtml = (data: CommentResponse[]) => {
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
