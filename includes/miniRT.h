#ifndef MINIRT_H
# define MINIRT_H

/* C System Headers */
# include <stdlib.h>
# include <unistd.h>
# include <stdio.h>
# include <errno.h>
# include <sys/types.h>
# include <sys/stat.h>
# include <fcntl.h>
# include <math.h>
# include <X11/keysym.h>
# include <X11/X.h>

/* 42 Library Headers */
# include "libft.h"
# include "mlx.h"

/* Project Headers */
# include "ambient_light.h"
# include "camera.h"
# include "colors.h"
# include "cylinder.h"
# include "function_tests.h"
# include "image.h"
# include "light.h"
# include "linked_list.h"
# include "matrix.h"
# include "plane.h"
# include "ray.h"
# include "scene.h"
# include "sphere.h"
# include "vector.h"

/* Macros */

/* Global Variables */

/* Structs */
typedef struct s_resolution
{
	int	x;
	int	y;
}			t_resolution;
typedef struct s_scene
{
	t_resolution res;
	t_camera	*cam;
	t_lst_ref	lights;
	t_lst_ref	ambient_lights;
	t_lst_ref	spheres;
	t_lst_ref	planes;
	t_lst_ref	cylinders;

}			t_scene;

/* Functions */

t_vec	mat_mult(t_mat3x3 mat, t_vec pt);
t_vec	vec_add(t_vec vec1, t_vec vec2);
t_vec	vec_sub(t_vec vec1, t_vec vec2);
t_vec	vec_mult(t_vec vec, float_t factor);
t_vec	vec_div(t_vec vec, float_t factor);
float_t	scalar_prod(t_vec vec1, t_vec vec2);
t_vec	cross_prod(t_vec vec1, t_vec vec2);
float_t	vec_length(t_vec vec);
t_vec	unit_vec(t_vec vec);
int		vec_cmp(t_vec vec1, t_vec vec2);
t_pt	ray_point_at(t_ray ray, float_t t);

void	*free_scene_null(t_scene *scene);
t_scene	*init_scene(void);
void	fill_dummy_scene(t_scene *scene);

t_data	*init_data(void);
void	*free_data_null(t_data *data);
void	*malloc_or_print_error(size_t size);
void	*free_null(void *ptr);

#endif