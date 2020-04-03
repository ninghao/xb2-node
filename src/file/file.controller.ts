import { Request, Response, NextFunction } from 'express';
import _ from 'lodash';
import { createFile } from './file.service';

/**
 * 上传文件
 */
export const store = async (
  request: Request,
  response: Response,
  next: NextFunction,
) => {
  // 当前用户
  const { id: userId } = request.user;

  // 所属内容
  const { post: postId } = request.query;

  // 文件信息
  const fileInfo = _.pick(request.file, [
    'originalname',
    'mimetype',
    'filename',
    'size',
  ]);

  try {
    // 保存文件信息
    const data = await createFile({
      ...fileInfo,
      userId,
      postId,
    });

    // 做出响应
    response.status(201).send(data);
  } catch (error) {
    next(error);
  }
};
