#include <zephyr/kernel.h>
#include <zephyr/drivers/gpio.h>
#include <zephyr/display/mb_display.h>
#include <zephyr/sys/util.h>

#define BUTTON_A DT_ALIAS(sw0)
#define BUTTON_B DT_ALIAS(sw1)

static const struct gpio_dt_spec btn_a = GPIO_DT_SPEC_GET(BUTTON_A, gpios);
static const struct gpio_dt_spec btn_b = GPIO_DT_SPEC_GET(BUTTON_B, gpios);
static struct gpio_callback button_cb_data;

/* global score tracker */
static int score = 0;

/**
 * @brief prints the score onto the LED display.
 *
 * @param score The score to print.
 */
static void print_score(int score)
{
	char score_buf[12];
	struct mb_display *disp = mb_display_get();

	snprintf(score_buf, sizeof(score_buf), "%d", score);

	mb_display_print(disp, MB_DISPLAY_MODE_SINGLE, SYS_FOREVER_MS, "%s", score_buf);
}

void button_pressed_callback(const struct device *dev, struct gpio_callback *cb, uint32_t pins)
{
	if (pins & BIT(btn_a.pin)) {
		score--;
	} else {
		score++;
	}
	score = CLAMP(score, 0, 9);
	print_score(score);
}

int main(void)
{
	if (!gpio_is_ready_dt(&btn_a)) {
		return 0;
	}

	if (!gpio_is_ready_dt(&btn_b)) {
		return 0;
	}

        /* setup button A and button B callback */
	gpio_pin_configure_dt(&btn_a, GPIO_INPUT);
	gpio_pin_configure_dt(&btn_b, GPIO_INPUT);

	gpio_pin_interrupt_configure_dt(&btn_a, GPIO_INT_EDGE_TO_ACTIVE);
	gpio_pin_interrupt_configure_dt(&btn_b, GPIO_INT_EDGE_TO_ACTIVE);

	gpio_init_callback(&button_cb_data, button_pressed_callback,
			   BIT(btn_a.pin) | BIT(btn_b.pin));

	gpio_add_callback(btn_a.port, &button_cb_data);

        /* start score of 0 */
        print_score(score);

	return 0;
}
