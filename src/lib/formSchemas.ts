import * as z from "zod";


// export const signInFormSchema = z.object({
//     email: z.string().trim().email({
//         message: "من فضلك ادخل بريد الكرتوني صحيح",
//     }),
//     password: z.string().trim().min(8, {
//         message: "كلمة السر يجب ان لا تقل عن 8 حروف",
//     })
// })

// export const signUpFormSchema = z.object({
//     username: z.string().min(3, {
//         message: "اسم المستخدم يجب ان لا يقل عن 3 حروف",
//     }),
//     email: z.string().email({
//         message: "من فضلك ادخل بريد الكرتوني صحيح",
//     }),
//     role: z.enum(["Admin", "SuperAdmin"]),
//     password: z.string().min(8, {
//         message: "كلمة السر يجب ان لا تقل عن 8 حروف",
//     }),
//     confirmPassword: z.string().min(8, {
//         message: "كلمة السر يجب ان لا تقل عن 8 حروف",
//     })
// }).refine((data) => data.password === data.confirmPassword, {
//     path: ["confirmPassword"],
//     message: "كلمة السر غير متطابقة",
// })


// export type SignInFormSchema = z.infer<typeof signInFormSchema>
// export type SignUpFormSchema = z.infer<typeof signUpFormSchema>