#pragma once
#if !defined(_WIN32)
#define ATG __attribute__((visibility("default")))
#elif defined(ATG_BUILD)
#define ATG __declspec(dllexport)
#else
#define ATG __declspec(dllimport)
#endif
#ifdef __cplusplus
extern "C" {
#endif
ATG void atg(void);
#ifdef __cplusplus
}
#endif
