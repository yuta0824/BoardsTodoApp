import axios from "axios";

export type CommentResponse = {
  content: string;
  commenter_name: string;
  commenter_avatar: string;
};

export const fetchGetComments = async (
  boardId: number,
  taskId: number
): Promise<CommentResponse[]> => {
  try {
    const response = await axios.get<CommentResponse[]>(
      `/boards/${boardId}/tasks/${taskId}/comments`
    );
    return response.data ?? [];
  } catch (error) {
    throw error;
  }
};
