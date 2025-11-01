import { CommentResponse } from "../types/CommentResponse";
import { escapeHtml } from "../utils/escapeHtml";

export const generateComments = (data: CommentResponse[]) => {
  const container = document.querySelector("#js-comment-container");
  if (!container) return;
  container.innerHTML = data
    .map((comment) => {
      const deleteAction = comment.isOwner
        ? `<button class="text-danger text-xs hover:underline js-delete-comment-button" data-comment-id="${comment.id}">削除</button>`
        : "";

      return `
        <div class="bg-white shadow-lg rounded-lg p-4 border border-brandGray flex items-center justify-between">
          <div>
            <div class="flex gap-2 items-center">
              <img
                class="flex-shrink-0 size-8 rounded-full"
                src="${escapeHtml(comment.commenterAvatar)}"
                alt="${escapeHtml(comment.commenterName)} avatar"
              />
              <p class="font-bold text-brandBlack">
                ${escapeHtml(comment.commenterName)}
              </p>
            </div>
            <div class="mt-4">${escapeHtml(comment.content)}</div>
          </div>
          ${deleteAction}
        </div>
      `;
    })
    .join("");
};
