import axios from "axios";
import { ensureCsrfToken, jsonRequest } from "../../utils/csrf";
import { CommentResponse } from "../../types/CommentResponse";

type CreateCommentPayload = {
  comment: {
    content: string;
  };
};

export const createCommentAndFetch = async (
  boardId: number,
  taskId: number,
  content: string
): Promise<CommentResponse[]> => {
  try {
    const payload: CreateCommentPayload = {
      comment: { content },
    };

    ensureCsrfToken();
    const response = await axios.post<CommentResponse[]>(
      `/api/v1/boards/${boardId}/tasks/${taskId}/comments`,
      payload,
      jsonRequest()
    );
    return response.data ?? [];
  } catch (error) {
    console.error("createCommentAndFetch error:", error);
    throw error;
  }
};
