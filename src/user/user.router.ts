import express from 'express';
import * as userController from './user.controller';

const router = express.Router();

/**
 * 创建用户
 */
router.post('/users', userController.store);

/**
 * 导出路由
 */
export default router;