import axios from "axios";
import { ensureCsrfToken, jsonRequest } from "../../utils/csrf";
import { TaskStatusResponse } from "../../types/TaskStatusResponse";

export const postTaskStatus = async (
  taskId: number,
  status: string
): Promise<TaskStatusResponse> => {
  try {
    ensureCsrfToken();
    const response = await axios.patch<TaskStatusResponse>(
      `/api/v1/tasks/${taskId}/status`,
      { status },
      jsonRequest()
    );
    return response.data;
  } catch (error) {
    console.error("postTaskStatus error:", error);
    throw error;
  }
};
