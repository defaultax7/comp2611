/*     */ package mars.mips.instructions.syscalls;
/*     */ 
/*     */ import javax.swing.JOptionPane;
/*     */ import mars.Globals;
/*     */ import mars.ProcessingException;
/*     */ import mars.ProgramStatement;
/*     */ import mars.mips.hardware.AddressErrorException;
/*     */ import mars.mips.hardware.Coprocessor1;
/*     */ import mars.mips.hardware.RegisterFile;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public class SyscallInputDialogFloat
/*     */   extends AbstractSyscall
/*     */ {
/*     */   public SyscallInputDialogFloat() {
/*  46 */     super(52, "InputDialogFloat");
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void simulate(ProgramStatement paramProgramStatement) throws ProcessingException {
/*  63 */     String str1 = new String();
/*  64 */     int i = RegisterFile.getValue(4);
/*  65 */     char[] arrayOfChar = { ' ' };
/*     */     
/*     */     try {
/*  68 */       arrayOfChar[0] = (char)Globals.memory.getByte(i);
/*  69 */       while (arrayOfChar[0] != '\000')
/*     */       {
/*  71 */         str1 = str1.concat(new String(arrayOfChar));
/*  72 */         i++;
/*  73 */         arrayOfChar[0] = (char)Globals.memory.getByte(i);
/*     */       }
/*     */     
/*  76 */     } catch (AddressErrorException addressErrorException) {
/*     */       
/*  78 */       throw new ProcessingException(paramProgramStatement, addressErrorException);
/*     */     } 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*  85 */     String str2 = null;
/*  86 */     str2 = JOptionPane.showInputDialog(str1);
/*     */ 
/*     */     
/*     */     try {
/*  90 */       Coprocessor1.setRegisterToFloat(0, 0.0F);
/*  91 */       if (str2 == null)
/*     */       {
/*  93 */         RegisterFile.updateRegister(5, -2);
/*     */       }
/*  95 */       else if (str2.length() == 0)
/*     */       {
/*  97 */         RegisterFile.updateRegister(5, -3);
/*     */       
/*     */       }
/*     */       else
/*     */       {
/* 102 */         float f = Float.parseFloat(str2);
/*     */ 
/*     */ 
/*     */ 
/*     */         
/* 107 */         Coprocessor1.setRegisterToFloat(0, f);
/* 108 */         RegisterFile.updateRegister(5, 0);
/*     */ 
/*     */       
/*     */       }
/*     */ 
/*     */     
/*     */     }
/* 115 */     catch (NumberFormatException numberFormatException) {
/*     */       
/* 117 */       RegisterFile.updateRegister(5, -1);
/*     */     } 
/*     */   }
/*     */ }


/* Location:              /Users/l/Desktop/COMP2611 TA 2020fall/prj/Web/2016F/project/NewMars_source_test.jar!/mars/mips/instructions/syscalls/SyscallInputDialogFloat.class
 * Java compiler version: 5 (49.0)
 * JD-Core Version:       1.1.3
 */