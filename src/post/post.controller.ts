import { Request, Response, NextFunction } from 'express';
import { getPosts } from './post.service';

/**
 * 内容列表
 */
export const index = (
  request: Request,
  response: Response,
  next: NextFunction
) => {
  const posts = getPosts();

  response.send(posts);
};