/**
 * 查询片断
 */
export const sqlFragment = {
  user: `
    JSON_OBJECT(
      'id', user.id,
      'name', user.name
    ) as user
  `,
  leftJoinUser: `
    LEFT JOIN user
    ON user.id = post.userId
  `,
  totalComments: `
    (
      SELECT
        COUNT(comment.id)
      FROM
        comment
      WHERE
        comment.postId = post.id
    ) as totalComments
  `,
};
