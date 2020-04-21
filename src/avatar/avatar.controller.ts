import { Request, Response, NextFunction } from 'express';

/**
 * 上传头像
 */
export const store = async (
  request: Request,
  response: Response,
  next: NextFunction,
) => {
  response.sendStatus(200);
};
