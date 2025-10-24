import { postTaskStatus } from "../api/task/postTaskStatus";

export const initTaskStatus = async () => {
  const taskElement = document.querySelector("[data-task-id]");
  if (!taskElement) return;

  const taskId = Number(taskElement.getAttribute("data-task-id"));
  if (!taskId) return;

  const button = taskElement.querySelector(
    "#js-task-status-button"
  ) as HTMLElement;
  if (!button) return;

  button.addEventListener("click", async () => {
    const currentStatus = button.dataset.status;
    if (currentStatus === "pending") return;
    const nextStatus = currentStatus === "todo" ? "done" : "todo";
    const { status } = await postTaskStatus(taskId, nextStatus);
    updateStatus(status, button);
  });
};

const updateStatus = (nextStatus: string, element: HTMLElement) => {
  element.textContent = nextStatus;
  element.dataset.status = nextStatus;
};
