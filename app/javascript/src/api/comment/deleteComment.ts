import axios from "axios";
import { ensureCsrfToken, jsonRequest } from "../../utils/csrf";
import { CommentResponse } from "../../types/CommentResponse";

export const deleteComment = async (
  commentId: number
): Promise<CommentResponse[]> => {
  try {
    ensureCsrfToken();
    const response = await axios.delete<CommentResponse[]>(
      `/api/v1/comments/${commentId}`,
      jsonRequest()
    );
    return response.data ?? [];
  } catch (error) {
    console.error("deleteComment error:", error);
    throw error;
  }
};
