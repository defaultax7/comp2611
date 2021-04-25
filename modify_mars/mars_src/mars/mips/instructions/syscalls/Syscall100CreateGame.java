/*    */ package mars.mips.instructions.syscalls;
/*    */ 
/*    */ import mars.ProcessingException;
/*    */ import mars.ProgramStatement;
/*    */ import mars.ext.game.GameConfigFile;
import mars.ext.game.GameScreen;
/*    */ import mars.util.SystemIO;

import java.awt.event.WindowEvent;

/*    */
/*    */ 
/*    */ public class Syscall100CreateGame
/*    */   extends AbstractSyscall
/*    */ {
/*    */   public Syscall100CreateGame() {
/* 13 */     super(100, "Create Game");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void simulate(ProgramStatement paramProgramStatement) throws ProcessingException {
/*    */     try {
 /* 20 */     GameScreen gs=  GameScreen.createIntance("/game/properties.txt");
 gs.addWindowListener(new java.awt.event.WindowAdapter(){
     @Override
     public void windowClosing(WindowEvent e) {
         super.windowClosing(e);
         System.out.println("i am shit");
         gs.stopAllSound();
//         gs.stopSound(7);
     }
 });
/*    */     }
/* 22 */     catch (Exception exception) {
/* 24 */       SystemIO.printString("In Creating Game, internal error has happened. Try restarting the MARS!");
/* 25 */       throw new ProcessingException();
/*    */     } 
/*    */   }
/*    */ }


/* Location:              /Users/l/Desktop/COMP2611 TA 2020fall/prj/Web/2016F/project/NewMars_source_test.jar!/mars/mips/instructions/syscalls/Syscall200CreateGame.class
 * Java compiler version: 5 (49.0)
 * JD-Core Version:       1.1.3
 */