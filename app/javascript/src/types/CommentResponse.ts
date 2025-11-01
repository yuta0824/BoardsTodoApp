import type { paths } from './generated/openapi';

type CommentsIndexResponse =
  paths['/api/v1/boards/{board_id}/tasks/{task_id}/comments']['get']['responses']['200']['content']['application/json'];

export type CommentResponse = CommentsIndexResponse[number];
