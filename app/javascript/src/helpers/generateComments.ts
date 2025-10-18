import { CommentResponse } from "../types/CommentResponse";
import { escapeHtml } from "../utils/escapeHtml";

export const generateComments = (data: CommentResponse[]) => {
  const container = document.querySelector("#js-comment-container");
  if (!container) return;
  container.innerHTML = data
    .map((comment) => {
      const deleteAction = comment.is_owner
        ? `<button class="text-danger text-xs hover:underline js-delete-comment-button" data-comment-id="${comment.id}">削除</button>`
        : "";

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
          ${deleteAction}
        </div>
      `;
    })
    .join("");
};
