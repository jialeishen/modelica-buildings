///////////////////////////////////////////////////////////////////////////////
///
/// \file ffd.h
///
/// \brief Main routine of Fast Fluid Dynamics
///
/// \author Wangda Zuo
///         University of Miami
///         W.Zuo@miami.edu
///         Mingang Jin, Qingyan Chen
///         Purdue University
///         Jin55@purdue.edu, YanChen@purdue.edu
///
/// \date   8/3/2013
///
///////////////////////////////////////////////////////////////////////////////
#ifndef _FFD_H
#define _FFD_H
#endif

#ifndef _DATA_STRUCTURE_H
#define _DATA_STRUCTURE_H
#include "data_structure.h"
#endif

#ifndef _FFD_DLL_H
#define FFD_DLL_H
#include "ffd_dll.h"
#endif

#ifndef _TIMING_H
#define _TIMING_H
#include "timing.h"
#endif

#ifndef _SOLVER_H
#define _SOLVER_H
#include "solver.h"
#endif

#ifndef _UTILITY_H
#define _UTILITY_H
#include "utility.h"
#endif

#ifndef _DATA_WRITER_H
#define _DATA_WRITER_H
#include "data_writer.h"
#endif

#ifndef _INITIALIZATION_H
#define _INITIALIZATION_H
#include "initialization.h"
#endif

#ifndef _VISUALIZATION_H
#define _VISUALIZATION_H
#include "visualization.h"
#endif

//static PARA_DATA para;
///////////////////////////////////////////////////////////////////////////////
/// Assign the parameter for coupled simulation
///
///\para cosim Pointer to the coupled simulation parameters
///
///\return 0 if no error occurred
///////////////////////////////////////////////////////////////////////////////
int ffd_cosimulation(CosimulationData *cosim);

///////////////////////////////////////////////////////////////////////////////
/// Main routine of FFD
///
///\para coupled simulation Integer to identify the simulation type
///
///\return 0 if no error occurred
///////////////////////////////////////////////////////////////////////////////
int ffd(int cosimulation);

///////////////////////////////////////////////////////////////////////////////
/// Allocate memory for variables
///
///\param para Pointer to FFD parameters
///
///\return No return needed
///////////////////////////////////////////////////////////////////////////////
int allocate_memory (PARA_DATA *para);

///////////////////////////////////////////////////////////////////////////////
/// GLUT display callback routines
///
///\return No return needed
///////////////////////////////////////////////////////////////////////////////
//static void display_func(void);

///////////////////////////////////////////////////////////////////////////////
/// GLUT idle callback routines  
///
///\return No return needed
///////////////////////////////////////////////////////////////////////////////
//static void idle_func(void);

///////////////////////////////////////////////////////////////////////////////
/// GLUT keyboard callback routines 
///
///\param key Character of the key
///\param x X-position
///\param y Y-Position
///
///\return No return needed
///////////////////////////////////////////////////////////////////////////////
//static void key_func(unsigned char key, int x, int y);

///////////////////////////////////////////////////////////////////////////////
/// GLUT motion callback routines  
///
///\param x X-position
///\param y Y-Position
///
///\return No return needed
///////////////////////////////////////////////////////////////////////////////
//static void motion_func(int x, int y);

///////////////////////////////////////////////////////////////////////////////
/// GLUT mouse callback routines  
///
///\param button Button of the mouse
///\param x X-position
///\param y Y-Position
///
///\return No return needed
///////////////////////////////////////////////////////////////////////////////
//static void mouse_func(int button, int state, int x, int y);

///////////////////////////////////////////////////////////////////////////////
/// Open_glut_window --- open a glut compatible window and set callbacks 
///
///\return No return needed
///////////////////////////////////////////////////////////////////////////////
//static void open_glut_window();

///////////////////////////////////////////////////////////////////////////////
/// GLUT reshape callback routines
///
///\param width Width of the window
///\param height Height of the window
///
///\return No return needed
///////////////////////////////////////////////////////////////////////////////
//static void reshape_func(int width, int height);
