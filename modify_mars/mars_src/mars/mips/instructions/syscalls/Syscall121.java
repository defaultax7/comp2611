package mars.mips.instructions.syscalls;

import mars.ProcessingException;
import mars.ProgramStatement;
import mars.ext.mine.MenuScreen;
import mars.mips.hardware.RegisterFile;

public class Syscall121 extends AbstractSyscall {
    public Syscall121() {
        super(121, "move cursor");
    }

    @Override
    public void simulate(ProgramStatement paramProgramStatement) throws ProcessingException {

        int a0 = RegisterFile.getValue(4); // x location
        int a1 = RegisterFile.getValue(5); // y location
        int a2 = RegisterFile.getValue(6); // action index

        MenuScreen menu = MenuScreen.getInstance();

        menu.move(a0,a1,a2);

    }
}

