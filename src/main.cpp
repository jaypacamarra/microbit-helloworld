volatile unsigned int cntr = 0x12345678;
volatile unsigned int cntr2 = 0;

int main()
{
        cntr++; 
        while(1)
        {
                cntr2++;
        }
}

// TODO: uncomment when MicroBit class defined
//#include <MicroBit.h>
//
//MicroBit uBit;
//
//int main()
//{
//    // Initialise the micro:bit runtime.
//    uBit.init();
//
//    // Insert your code here!
//    uBit.display.scroll("HELLO WORLD! :)");
//}


