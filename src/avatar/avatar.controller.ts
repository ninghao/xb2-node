import { Request, Response, NextFunction } from 'express';
import _ from 'lodash';
import { createAvatar } from './avatar.service';

/**
 * 上传头像
 */
export const store = async (
  request: Request,
  response: Response,
  next: NextFunction,
) => {
  // 当前用户 ID
  const { id: userId } = request.user;

  // 头像文件信息
  const fileInfo = _.pick(request.file, ['mimetype', 'filename', 'size']);

  // 准备头像数据
  const avatar = {
    ...fileInfo,
    userId,
  };

  try {
    // 保存头像数据
    const data = await createAvatar(avatar);

    // 做出响应
    response.status(201).send(data);
  } catch (error) {
    next(error);
  }
};
