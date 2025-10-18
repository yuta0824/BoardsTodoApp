import axios from "axios";
import { ensureCsrfToken, jsonRequest } from "../../utils/csrf";

type PostCommentPayload = {
  comment: {
    content: string;
  };
};

export const postComment = async (
  boardId: number,
  taskId: number,
  content: string
): Promise<void> => {
  ensureCsrfToken();
  const payload: PostCommentPayload = {
    comment: { content },
  };
  await axios.post(
    `/boards/${boardId}/tasks/${taskId}/comments`,
    payload,
    jsonRequest()
  );
};
