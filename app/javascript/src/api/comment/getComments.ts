import axios from "axios";
import { CommentResponse } from "../../types/CommentResponse";

export const getComments = async (
  boardId: number,
  taskId: number
): Promise<CommentResponse[]> => {
  try {
    const response = await axios.get<CommentResponse[]>(
      `/api/v1/boards/${boardId}/tasks/${taskId}/comments`
    );
    return response.data;
  } catch (error) {
    console.error("getComments error:", error);
    throw error;
  }
};
