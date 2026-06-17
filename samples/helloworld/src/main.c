#include <zephyr/display/mb_display.h>

int main(void)
{
        struct mb_display *disp = mb_display_get();

        mb_display_print(disp, MB_DISPLAY_MODE_DEFAULT | MB_DISPLAY_FLAG_LOOP,
                        800, "Hello World!");

        return 0;
}
