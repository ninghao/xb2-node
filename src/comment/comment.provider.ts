/**
 * SQL 查询片断
 */
export const sqlFragment = {
  leftJoinUser: `
    LEFT JOIN user
      ON user.id = comment.userId
    LEFT JOIN avatar
      ON user.id = avatar.userId
  `,
  user: `
    JSON_OBJECT(
      'id', user.id,
      'name', user.name,
      'avatar', IF(COUNT(avatar.id), 1, NULL)
    ) AS user
  `,
  leftJoinPost: `
    LEFT JOIN post
      ON post.id = comment.postId
  `,
  post: `
    JSON_OBJECT(
      'id', post.id,
      'title', post.title
    ) AS post
  `,
};
