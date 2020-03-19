import express from 'express';
import * as postController from './post.controller';

const router = express.Router();

/**
 * 内容列表
 */
router.get('/posts', postController.index);

/**
 * 导出路由
 */
export default router;