import axios from "axios";
import { ensureCsrfToken, jsonRequest } from "../../utils/csrf";
import { CommentResponse } from "../../types/CommentResponse";

type PostCommentPayload = {
  comment: {
    content: string;
  };
};

export const postComment = async (
  boardId: number,
  taskId: number,
  content: string
): Promise<CommentResponse[]> => {
  try {
    const payload: PostCommentPayload = {
      comment: { content },
    };

    ensureCsrfToken();
    const response = await axios.post<CommentResponse[]>(
      `/boards/${boardId}/tasks/${taskId}/comments`,
      payload,
      jsonRequest()
    );
    return response.data ?? [];
  } catch (error) {
    throw error;
  }
};
