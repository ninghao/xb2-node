import path from 'path';
import fs from 'fs';
import { Request, Response, NextFunction } from 'express';
import _ from 'lodash';
import { createAvatar, findAvatarByUserId } from './avatar.service';
import { avatarProcessor } from './avatar.middleware';

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

/**
 * 头像服务
 */
export const serve = async (
  request: Request,
  response: Response,
  next: NextFunction,
) => {
  // 用户 ID
  const { userId } = request.params;

  try {
    // 查找头像信息
    const avatar = await findAvatarByUserId(parseInt(userId, 10));

    if (!avatar) {
      throw new Error('FILE_NOT_FOUND');
    }

    // 要提供的头像尺寸
    const { size } = request.query;

    // 文件名与目录
    let filename = avatar.filename;
    let root = path.join('uploads', 'avatar');
    let resized = 'resized';

    if (size) {
      // 可用的头像尺寸
      const imageSizes = ['large', 'medium', 'small'];

      // 测试可用的头像尺寸
      if (!imageSizes.some(item => item == size)) {
        throw new Error('FILE_NOT_FOUND');
      }

      // 检查文件是否存在
      const fileExist = fs.existsSync(
        path.join(root, resized, `${filename}-${size}`),
      );

      if (!fileExist) {
        throw new Error('FILE_NOT_FOUND');
      }

      if (fileExist) {
        filename = `${filename}-${size}`;
        root = path.join(root, resized);
      }
    }

    // 做出响应
    response.sendFile(filename, {
      root,
      headers: {
        'Content-Type': avatar.mimetype,
      },
    });
  } catch (error) {
    next(error);
  }
};
