/*    */ package mars.mips.instructions.syscalls;
/*    */ 
/*    */ import mars.ProcessingException;
/*    */ import mars.ProgramStatement;
/*    */ import mars.ext.game.GameObject;
/*    */ import mars.ext.game.GameScreen;
/*    */ import mars.ext.game.GameTextObject;
/*    */ import mars.mips.hardware.RegisterFile;
/*    */ import mars.util.SystemIO;

import java.awt.*;

/*    */
/*    */ 
/*    */ 
/*    */ public class Syscall105CreateGameText
/*    */   extends AbstractSyscall
/*    */ {
/*    */   public Syscall105CreateGameText() {
/* 17 */     super(105, "Create Text Object");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public void simulate(ProgramStatement paramProgramStatement) throws ProcessingException {
/* 24 */     int i = RegisterFile.getValue(4);
/* 25 */     int j = RegisterFile.getValue(5)+32;
/* 26 */     int k = RegisterFile.getValue(6)+16;
/* 27 */     String str = SyscallGameHelper.getStringFromMIPS(RegisterFile.getValue(7));
/* 28 */     GameTextObject gameTextObject = new GameTextObject(i, j, k);
/*    */     try {
///* 30 */       gameTextObject.setColor(13433072); //65280
        gameTextObject.setColor(Color.WHITE.getRGB());
/* 31 */     } catch (Exception exception) {}
/*    */     
/* 33 */     gameTextObject.setText(str);
/* 34 */     GameScreen gameScreen = GameScreen.getInstance();
/* 35 */     if (gameScreen == null) {
/*    */       
/* 37 */       SystemIO.printString("In Creating Text Object, but GameScreen has not been created first!");
/* 38 */       throw new ProcessingException();
/*    */     } 
/* 40 */     gameScreen.addGameObject(i, (GameObject)gameTextObject, 3);
/*    */   }
/*    */ }


/* Location:              /Users/l/Desktop/COMP2611 TA 2020fall/prj/Web/2016F/project/NewMars_source_test.jar!/mars/mips/instructions/syscalls/Syscall207CreateGameText.class
 * Java compiler version: 5 (49.0)
 * JD-Core Version:       1.1.3
 */