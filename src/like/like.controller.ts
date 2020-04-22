import { Request, Response, NextFunction } from 'express';
import { createUserLikePost } from './like.service';

/**
 * 点赞内容
 */
export const storeUserLikePost = async (
  request: Request,
  response: Response,
  next: NextFunction,
) => {
  // 准备数据
  const { postId } = request.params;
  const { id: userId } = request.user;

  // 点赞内容
  try {
    const data = await createUserLikePost(userId, parseInt(postId, 10));

    // 做出响应
    response.status(201).send(data);
  } catch (error) {
    next(error);
  }
};
