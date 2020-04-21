import express from 'express';
import * as avatarController from './avatar.controller';
import { authGuard } from '../auth/auth.middleware';
import { avatarInterceptor, avatarProcessor } from './avatar.middleware';

const router = express.Router();

/**
 * 上传头像
 */
router.post(
  '/avatar',
  authGuard,
  avatarInterceptor,
  avatarProcessor,
  avatarController.store,
);

/**
 * 导出路由
 */
export default router;
