import { Request, Response, NextFunction } from 'express';

/**
 * 上传文件
 */
export const store = async (
  request: Request,
  response: Response,
  next: NextFunction,
) => {
  console.log(request.file);
  response.sendStatus(200);
};
