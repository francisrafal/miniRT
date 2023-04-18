NAME			:= miniRT
CC				:= clang
RM		    	:= rm -f
FLAGS			:= -Wall -Wextra -Werror
DEBUG			:= -g

HEADDIR			:= ./includes/
HEADLIST		:= miniRT.h \
					ambient_light.h \
					camera.h \
					colors.h \
					cylinder.h \
					function_tests.h \
					image.h \
					light.h \
					linked_list.h \
					matrix.h \
					plane.h \
					ray.h \
					scene.h \
					sphere.h \
					vector.h

HEADERS			:= $(addprefix ${HEADDIR}, ${HEADLIST})

SRCSDIR			:= ./src/
SRCSLIST		:= main.c \
					ambient_light.c \
					camera.c \
					closest_hit.c \
					colors.c \
					cylinder.c \
					data.c \
					diffuse_light.c \
					fill_scene.c \
					free.c \
					ft_atof.c \
					function_tests.c \
					hooks.c \
					light.c \
					linked_list.c \
					malloc_safe.c \
					matrix_and_vector_operations.c \
					matrix.c \
					plane.c \
					rays.c \
					read_file.c \
					render_plane.c \
					render.c \
					scene.c \
					specular_light.c \
					sphere.c \
					validate_ambient_light.c \
					validate_arguments.c \
					validate_camera.c \
					validate_cylinder.c \
					validate_light.c \
					validate_numbers.c \
					validate_plane.c \
					validate_scene.c \
					validate_sphere.c \
					vector_helpers.c 
					
SRCS			:= $(addprefix ${SRCSDIR}, ${SRCSLIST})

OBJSDIR			:= ./obj/
OBJSLIST		:= ${SRCSLIST:.c=.o}
OBJS			:= $(addprefix ${OBJSDIR}, ${OBJSLIST})

MLXDIR			:= ./minilibx-linux/
MLX				:= ${MLXDIR}libmlx.a

LIBFTDIR		:= ./libft/
LIBFT			:= ${LIBFTDIR}libft.a

LIBS			:= -L${LIBFTDIR} -L${MLXDIR} -lft -lmlx -lXext -lX11 -lm
INCS			:= -I${HEADDIR} -I${LIBFTDIR} -I${MLXDIR}

CYAN			:= \033[0;36m
RESET			:= \033[0m

${NAME}:		${MLX} ${LIBFT} ${OBJSDIR} ${OBJS}
				@echo ""
				@echo "${CYAN}Compiling ${NAME} ...${RESET}"
				${CC} ${FLAGS} ${DEBUG} ${OBJS} -o ${NAME} ${LIBS} ${INCS}
				@echo ""
				@echo "${CYAN}${NAME} Created${RESET}"
${MLX}:
				@echo ""
				@echo "${CYAN}Compiling ${MLX} ...${RESET}"
				git submodule init
				git submodule update
				make -C ${MLXDIR}

${LIBFT}:
				make -C ${LIBFTDIR}

${OBJSDIR}%.o:	${SRCSDIR}%.c ${HEADERS} compiling
				${CC} ${FLAGS} ${DEBUG} ${INCS} -c $< -o $@

${OBJSDIR}:
				mkdir -p ${OBJSDIR}

.PHONY:			all clean fclean re test 

.INTERMEDIATE:	compiling

compiling:
				@echo ""
				@echo "${CYAN}Compiling Objects ...${RESET}"

all:			${NAME}

clean:
				@echo ""
				@echo "${CYAN}Deleting ${NAME} Objects ...${RESET}"
				${RM} -r ${OBJSDIR}
				make -C ${LIBFTDIR} clean

fclean:			clean
				@echo ""
				@echo "${CYAN}Deleting ${NAME} Executable ...${RESET}"
				${RM} ${NAME}
				make -C ${LIBFTDIR} fclean

re:				fclean all

test:			all
				./${NAME} scenes/reflectiontest3.rt

val:			all
				valgrind \
				--leak-check=full \
				--show-leak-kinds=all \
				--track-origins=yes \
				./${NAME} scenes/dummy_scene.rt
